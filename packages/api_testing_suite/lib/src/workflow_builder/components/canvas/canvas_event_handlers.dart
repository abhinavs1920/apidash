import 'package:api_testing_suite/src/workflow_builder/providers/providers.dart';
import '../../models/workflow_connection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/workflow_node_model.dart';


mixin CanvasEventHandlers<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  TransformationController get transformationController;

  String? _draggedNodeId;
  Offset? _dragOffsetFromNodeTopLeft;
  String? _sourceNodeId;
  Offset? _connectionStart;
  Offset? _connectionEnd;

  String? get draggedNodeId => _draggedNodeId;
  set draggedNodeId(String? value) => setState(() => _draggedNodeId = value);

  Offset? get dragOffsetFromNodeTopLeft => _dragOffsetFromNodeTopLeft;
  set dragOffsetFromNodeTopLeft(Offset? value) => setState(() => _dragOffsetFromNodeTopLeft = value);

  String? get sourceNodeId => _sourceNodeId;
  set sourceNodeId(String? value) => setState(() => _sourceNodeId = value);

  Offset? get connectionStart => _connectionStart;
  set connectionStart(Offset? value) => setState(() => _connectionStart = value);

  Offset? get connectionEnd => _connectionEnd;
  set connectionEnd(Offset? value) => setState(() => _connectionEnd = value);

  void handleApiNodeAdded(WidgetRef ref, String workflowId, String requestId, Offset position) {
    debugPrint('[CanvasEventHandlers] handleApiNodeAdded called with workflowId: $workflowId, requestId: $requestId, position: $position');
    try {
      final renderBox = context.findRenderObject() as RenderBox;
      final viewportCenter = transformationController.toScene(
        Offset(
          renderBox.size.width / 2,
          renderBox.size.height / 2,
        ),
      );

      final finalPosition = position.dx == 0 && position.dy == 0
          ? Offset(viewportCenter.dx - 100, viewportCenter.dy - 40)
          : position;

      final nodeModel = WorkflowNodeModel.create(
        requestId: requestId, 
        position: finalPosition,
        label: 'API Request ${DateTime.now().millisecondsSinceEpoch % 1000}',
      );
      
      ref.read(workflowsNotifierProvider.notifier).addNode(workflowId, nodeModel);
      
      debugPrint('Added node with ID: ${nodeModel.id} at position: ${nodeModel.position}');
      
      final workflows = ref.read(workflowsNotifierProvider);
      final workflow = workflows.firstWhere((w) => w.id == workflowId);
      debugPrint('Current nodes in workflow: ${workflow.nodes.length}');
      for (final node in workflow.nodes) {
        debugPrint('Node ID: ${node.id}, Position: ${node.position}, Label: ${node.label}');
      }
    } catch (e) {
      debugPrint('Error adding API node: $e');
    }
  }

  void handleNodeDrag(WidgetRef ref, String workflowId, String nodeId, Offset position) {

    ref.read(workflowsNotifierProvider.notifier).updateNodePosition(workflowId, nodeId, position);
  }
  
  void handleNodeDragStart(WidgetRef ref, String workflowId, String nodeId, Offset globalPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    
    final workflows = ref.read(workflowsNotifierProvider);
    final workflow = workflows.firstWhere((w) => w.id == workflowId);
    final node = workflow.nodes.firstWhere((n) => n.id == nodeId);
    
    final nodeTopLeft = box.localToGlobal(node.position);
    
    draggedNodeId = nodeId;
    dragOffsetFromNodeTopLeft = globalPosition - nodeTopLeft;
    
    ref.read(workflowsNotifierProvider.notifier).startNodeDrag(workflowId, nodeId, node.position);
  }
  
  void handleNodeDragUpdate(WidgetRef ref, String workflowId, Offset globalPosition) {
    if (draggedNodeId != null && dragOffsetFromNodeTopLeft != null) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      
      final localPosition = box.globalToLocal(globalPosition - dragOffsetFromNodeTopLeft!);
      
      handleNodeDrag(ref, workflowId, draggedNodeId!, localPosition);
    }
  }
  
  void handleNodeDragEnd(WidgetRef ref, String workflowId) {
    if (draggedNodeId != null) {
      ref.read(workflowsNotifierProvider.notifier).finishNodeDrag(workflowId, draggedNodeId!);
      
      draggedNodeId = null;
      dragOffsetFromNodeTopLeft = null;
    }
  }

  void handleNodeTap(WidgetRef ref, String workflowId, String nodeId, Offset position) {
    final isConnectionModeActive = ref.read(connectionModeProvider);
    
    if (isConnectionModeActive) {
      if (sourceNodeId == null) {
        debugPrint('Setting source node: $nodeId');
        sourceNodeId = nodeId;
        connectionStart = position;
        
        setState(() {});
      } 
      else if (sourceNodeId != nodeId) {
        debugPrint('Creating connection from ${sourceNodeId!} to $nodeId');
        handleConnectionCreated(ref, workflowId, sourceNodeId!, nodeId);
        
        sourceNodeId = null;
        connectionStart = null;
        connectionEnd = null;
      }
    } else {
      ref.read(selectedNodeIdProvider.notifier).state = nodeId;
    }
  }

  void handleConnectionCreated(WidgetRef ref, String workflowId, String sourceNodeId, String targetNodeId) {
    try {
      final workflows = ref.read(workflowsNotifierProvider);
      final workflow = workflows.firstWhere((w) => w.id == workflowId);
      final sourceNode = workflow.nodes.firstWhere(
        (n) => n.id == sourceNodeId, 
        orElse: () => throw Exception('Source node not found')
      );
      
      final connection = WorkflowConnectionModel.create(
        sourceId: sourceNodeId,
        targetId: targetNodeId,
        workflowId: workflowId,
        position: sourceNode.position,
      );
      
      ref.read(workflowsNotifierProvider.notifier).createConnection(workflowId, sourceNodeId, targetNodeId);
      debugPrint('Added connection from $sourceNodeId to $targetNodeId');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connected nodes'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      debugPrint('Error creating connection: $e');
    }
  }
}

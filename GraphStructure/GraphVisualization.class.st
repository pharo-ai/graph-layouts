"
Methods to Visualize Graph Layouts
"
Class {
	#name : #GraphVisualization,
	#superclass : #Object,
	#instVars : [
		'vertices',
		'edges'
	],
	#category : #GraphStructure
}

{ #category : #'as yet unclassified' }
GraphVisualization >> drawGraphBoxNode: graph [

<inspectorPresentationOrder: 0 title: 'Graph'>
| c box label arrow nodes localEdges put |

vertices:= graph vertices.
edges:= graph edges.

nodes:= OrderedCollection new.
localEdges:= OrderedCollection new.

vertices do: [:each | nodes add: each].

edges do: [:each | 
	put:= ((each from) -> (each to)).
	localEdges add: put].

c := RSCanvas new.

c addAll: (RSComposite models: vertices forEach: [:shape :model |
    label := (RSLabel new
        text: (model model) asString;
        color: Color black;
        yourself).
    box := RSBox new
          extent: label extent y @ label extent y;
        color: Color white;
        borderColor: Color black.
    shape
        add: box;
        add: label;
        yourself.  
  
     ]).
c nodes @ RSDraggable new.


c nodes doWithIndex: [ :shape :index |
    shape position: (nodes at: index) position ].

arrow := RSShapeFactory arrow.

RSLineBuilder arrowedLine
    color: Color black;
    withBorderAttachPoint;
    shapes: c nodes;
    useAssociations: localEdges.

c @ RSCanvasController.
^c

]

{ #category : #'as yet unclassified' }
GraphVisualization >> drawGraphCircleNode: graph [

<inspectorPresentationOrder: 0 title: 'Graph'>
| c box label arrow nodes localEdges put |

vertices:= graph vertices.
edges:= graph edges.

nodes:= OrderedCollection new.
localEdges:= OrderedCollection new.

vertices do: [:each | nodes add: each].

edges do: [:each | 
	put:= ((each from) -> (each to)).
	localEdges add: put].

c := RSCanvas new.

c addAll: (RSComposite models: vertices forEach: [:shape :model |
    label := (RSLabel new
        text: (model model) asString;
        color: Color black;
        yourself).
    box := RSCircle new
          extent: label extent y @ label extent y;
        color: Color white;
        borderColor: Color black.
    shape
        add: box;
        add: label;
        yourself.  
  
     ]).
c nodes @ RSDraggable new.


c nodes doWithIndex: [ :shape :index |
    shape position: (nodes at: index) position ].

arrow := RSShapeFactory arrow.

RSLineBuilder arrowedLine
    color: Color black;
    withBorderAttachPoint;
    shapes: c nodes;
    useAssociations: localEdges.

c @ RSCanvasController.
^c

]

"
I represent a graph structure.
"
Class {
	#name : #Graph,
	#superclass : #Object,
	#instVars : [
		'edges',
		'vertices',
		'undirected'
	],
	#category : #GraphStructure
}

{ #category : #adding }
Graph >> addEdgeFrom: ver1 to: ver2 [
	"Addes new edge between given vertices."

	| edge |
	edge := Edge new.
	self
		addOnEdge: edge from: ver1;
		addOnEdge: edge to: ver2.
	ver1 addOutNeighbour: ver2.
	ver2 addInNeighbour: ver1.
	self edges add: edge.
	self undirected ifTrue: [ self addingUndirectedEdgeFrom: ver2 to: ver1 ]
]

{ #category : #adding }
Graph >> addEdgeObject: anEdge [
	"Addes given edge to vertices."
	
	self edges add: anEdge 
]

{ #category : #adding }
Graph >> addOnEdge: edge from: ver1 [
	"Put ver1 as vertex from in given edge."
	
	(self vertexExists: ver1)
		ifFalse: [ self addVertex: (ver1 vertexValue)].
	edge fromVertex: ver1 
]

{ #category : #adding }
Graph >> addOnEdge: edge to: ver1 [
	"Put ver1 as vertex to in given edge."
	
	(self vertexExists: ver1)
		ifFalse: [ self addVertex: (ver1 vertexValue) ]. 
	edge toVertex: ver1
]

{ #category : #adding }
Graph >> addVertex: vertex [ 
	"Addes given vertex to vertices."
	
	self vertices add: vertex
]

{ #category : #adding }
Graph >> addVertexWithValue: value [ 
	"Addes a new vertex made with given value to vertices."
	
	|tmp|
	tmp := Vertex new.
	tmp vertexValue: value.
	self vertices add: tmp.
	^tmp
]

{ #category : #adding }
Graph >> addingUndirectedEdgeFrom: ver1 to: ver2 [
	"In undirected graph adding of edges."
	
   |tmp1|
	tmp1 := Edge new.
	tmp1 fromVertex: ver1.
	tmp1 toVertex: ver2.
	ver1 addOutNeighbour: ver2.
	ver2 addInNeighbour: ver1.
	self edges add: tmp1
]

{ #category : #'as yet unclassified' }
Graph >> drawGraphCircleNode [

<inspectorPresentationOrder: 0 title: 'Graph'>
| c nodes localEdges put box label |

c := RSCanvas new.
nodes:= OrderedCollection new.
localEdges:= OrderedCollection new.

vertices do: [:each | nodes add: each model].
edges do: [:each | 
	put:= OrderedCollection new.
	put add: (each from model).
	put add: (each to model).
	localEdges add: put].

c addAll: (RSComposite models: nodes forEach: [:shape :model |
    label := (RSLabel new
        text: model asString;
        color: Color black;
        yourself).
    box := RSCircle new
          extent: label extent y @ label extent y;
        color: Color white;
        borderColor: Color black.
    shape
        add: box;
        add: label;
        yourself
     ]).
c nodes @ RSDraggable new.

c @ RSCanvasController new.

RSLineBuilder arrowedLine
    color: Color black;
    withBorderAttachPoint;
    shapes: c nodes;
    useAssociations: (localEdges collect: [:each | each first -> each last ]).
    
RSCircleLayout on: c nodes.
^c
]

{ #category : #'checking existance' }
Graph >> edgeExists: edge [
	"Inspecting if given egde exists in graph."
	
	|tmp|
	tmp := false.
	edges do: [ :each| (each equals: edge )
		ifTrue: [ tmp :=true ] 
		].
	^tmp
	
]

{ #category : #getter }
Graph >> edges [
	^ edges
]

{ #category : #setter }
Graph >> edges: anObject [
	edges := anObject
]

{ #category : #initialization }
Graph >> initialize [ 
  "Initialization of Graph objects."

  	edges := Set new.
  	vertices := Set new.
	undirected := false

]

{ #category : #getter }
Graph >> undirected [ 
	^undirected
]

{ #category : #setter }
Graph >> undirected: anBoolean [
	undirected := anBoolean
]

{ #category : #'checking existance' }
Graph >> vertexExists: vertix [
	"Inspects if given vertix exists in graph."
	
	|tmp|
	tmp := false.
	vertices do: [ :each| ((each vertexValue) = (vertix vertexValue) )
		ifTrue: [ tmp :=true ] 
		].
	^tmp
	
]

{ #category : #getter }
Graph >> vertices [
	^ vertices
]

{ #category : #setter }
Graph >> vertices: anInteger [
	vertices := anInteger 
]

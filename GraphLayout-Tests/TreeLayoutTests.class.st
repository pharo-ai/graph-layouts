"
I represent colection of tests for the class GraphTreeLayout.
"
Class {
	#name : #TreeLayoutTests,
	#superclass : #TestCase,
	#category : #'GraphLayout-Tests'
}

{ #category : #tests }
TreeLayoutTests >> testChildrenForExcept [
"A test that checks computing children(out neighbors) for given vertex, exept the ones we already layouted."
	|gr v1 v2 v3 v4 layout used|
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v3 := gr addVertexWithValue: 3.
	v4 := gr addVertexWithValue: 4.
	gr addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	used := Set new.
	used add: v1.
	layout :=GraphTreeLayout new.
	"layout alreadyLayoutedVertices add: v1."
	self assert: ((layout childrenFor: v3 except: used) size = 1)
]

{ #category : #tests }
TreeLayoutTests >> testComputeChildrenFor [
"A test that checks computing children(out neighbors) for given vertex."
	|gr v1 v2 v3 v4 layout|
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v3 := gr addVertexWithValue: 3.
	v4 := gr addVertexWithValue: 4.
	gr addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	layout :=GraphTreeLayout new.
	self assert: ((layout computeChildrenFor: v3) size = 2)
]

{ #category : #tests }
TreeLayoutTests >> testDoExecuteGrid [
"A test that checks execution of grid layout"
	|gr v1 v2 v3 v4 layout used|
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v3 := gr addVertexWithValue: 3.
	v4 := gr addVertexWithValue: 4.
	gr addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	used := Set new.
	used add: v1.
	layout :=GraphGridLayout  new.
	layout doExecute: (gr vertices ).
	self assert: ((v1 pointer) = 0@0)
]

{ #category : #tests }
TreeLayoutTests >> testGridSetLineItemsCount [ 
"A test that checks initialization of lineClountItemsBlock variable."
	|tmp graph v1 v2 point test|
	graph := Graph new.
	v1 := graph addVertexWithValue: 1.
	v2 := graph addVertexWithValue: 2.
	test := 2@1.
	tmp := GAbstractGridLayout new.
	point := tmp setLineItemsCount: (graph vertices ).
	self assert: (point = test)
]

{ #category : #tests }
TreeLayoutTests >> testGridSetLineItemsCountMoreThan3 [ 
"A test that checks initialization of lineClountItemsBlock variable."
	|tmp graph v1 v2 v3 v4 point test|
	graph := Graph new.
	v1 := graph addVertexWithValue: 1.
	v2 := graph addVertexWithValue: 2.
	v3 := graph addVertexWithValue: 3.
	v4 := graph addVertexWithValue: 4.
	test := 2@2.
	tmp := GAbstractGridLayout new.
	point := tmp setLineItemsCount: (graph vertices ).
	self assert: (point = test)
]

{ #category : #tests }
TreeLayoutTests >> testInitializeAbstractGridL [ 
"A test that checks initialization of GAbstractGridLayout object."
	|tmp|
	tmp := GAbstractGridLayout  new.
	self assert: (tmp gapSize  = 5)
]

{ #category : #tests }
TreeLayoutTests >> testInitializeAbstractGridLineItems [ 
"A test that checks initialization of lineClountItemsBlock variable."
	|tmp|
	tmp := GAbstractGridLayout  new.
	self assert: (tmp lineItemsCountBlock = 10)
]

{ #category : #tests }
TreeLayoutTests >> testInitializeTreeL [ 
"A test that checks initialization of GraphTreeLayout object."
	|tmp|
	tmp := GraphTreeLayout new.
	self deny: (tmp alreadyLayoutedVertices = nil)
]
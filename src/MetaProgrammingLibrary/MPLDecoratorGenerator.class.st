Class {
	#name : #MPLDecoratorGenerator,
	#superclass : #MPLAbstractGenerator,
	#instVars : [
		'decoratorClass',
		'decoratorInstVarName',
		'classToBeDecorated',
		'methodsForDecorator'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #accessing }
MPLDecoratorGenerator >> classToBeDecorated [
	^ classToBeDecorated
]

{ #category : #accessing }
MPLDecoratorGenerator >> classToBeDecorated: anObject [
	classToBeDecorated := anObject
]

{ #category : #accessing }
MPLDecoratorGenerator >> decoratorClass [
	^ decoratorClass
]

{ #category : #accessing }
MPLDecoratorGenerator >> decoratorClass: anObject [
	decoratorClass := anObject
]

{ #category : #accessing }
MPLDecoratorGenerator >> decoratorInstVarName [
	^ decoratorInstVarName
]

{ #category : #accessing }
MPLDecoratorGenerator >> decoratorInstVarName: anObject [
	decoratorInstVarName := anObject
]

{ #category : #generating }
MPLDecoratorGenerator >> execute [
	self methodsForDecorator do: [ :compiledMethod |
		|selector ast hasSelfReturn|
		selector := compiledMethod selector.
		ast := compiledMethod parseTree.
		hasSelfReturn := false.
		ast acceptVisitor: (RBGenericNodeVisitor new
			visitBlock: [ :n | hasSelfReturn := hasSelfReturn or: [ n isReturn and: [ n value isSelf not ] ] ]).
		hasSelfReturn
			ifTrue: [  ]
			ifFalse: [  ] ] 
]

{ #category : #accessing }
MPLDecoratorGenerator >> methodsForDecorator [
	^ methodsForDecorator
]

{ #category : #accessing }
MPLDecoratorGenerator >> methodsForDecorator: anObject [
	methodsForDecorator := anObject
]

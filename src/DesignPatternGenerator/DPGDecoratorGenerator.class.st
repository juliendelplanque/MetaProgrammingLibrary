Class {
	#name : #DPGDecoratorGenerator,
	#superclass : #DPGAbstractGenerator,
	#instVars : [
		'decoratorClass',
		'decoratorInstVarName',
		'classToBeDecorated',
		'methodsForDecorator'
	],
	#category : #DesignPatternGenerator
}

{ #category : #accessing }
DPGDecoratorGenerator >> classToBeDecorated [
	^ classToBeDecorated
]

{ #category : #accessing }
DPGDecoratorGenerator >> classToBeDecorated: anObject [
	classToBeDecorated := anObject
]

{ #category : #accessing }
DPGDecoratorGenerator >> decoratorClass [
	^ decoratorClass
]

{ #category : #accessing }
DPGDecoratorGenerator >> decoratorClass: anObject [
	decoratorClass := anObject
]

{ #category : #accessing }
DPGDecoratorGenerator >> decoratorInstVarName [
	^ decoratorInstVarName
]

{ #category : #accessing }
DPGDecoratorGenerator >> decoratorInstVarName: anObject [
	decoratorInstVarName := anObject
]

{ #category : #generating }
DPGDecoratorGenerator >> generate [
	self methodsForDecorator do: [ :compiledMethod |
		|selector ast hasSelfReturn|
		selector := compiledMethod selector.
		ast := compiledMethod parseTree.
		hasSelfReturn := false.
		ast acceptVisitor: (RBGenericNodeVisitor new
			visitBlock: [ :n | hasSelfReturn := hasSelfReturn or: [ n isReturn and: [ n value isSelf not ] ] ]) ] 
]

{ #category : #accessing }
DPGDecoratorGenerator >> methodsForDecorator [
	^ methodsForDecorator
]

{ #category : #accessing }
DPGDecoratorGenerator >> methodsForDecorator: anObject [
	methodsForDecorator := anObject
]

Class {
	#name : #MPLBatchMethodGenerator,
	#superclass : #MPLAbstractCommand,
	#instVars : [
		'targetClasses',
		'template',
		'contextBlock',
		'protocol'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #accessing }
MPLBatchMethodGenerator >> context: aDictionary [
	self contextBlock: [ :c | aDictionary ]
]

{ #category : #accessing }
MPLBatchMethodGenerator >> contextBlock [
	^ contextBlock
]

{ #category : #accessing }
MPLBatchMethodGenerator >> contextBlock: anObject [
	contextBlock := anObject
]

{ #category : #executing }
MPLBatchMethodGenerator >> execute [
	self targetClasses do: [ :c |
	(self template substituteParametersWith: (self contextBlock value: c))
		withGeneratedPragma: self withGeneratedPragma;
		installOn: c ]
]

{ #category : #initialization }
MPLBatchMethodGenerator >> initialize [
	super initialize.
	self context: Dictionary empty
]

{ #category : #accessing }
MPLBatchMethodGenerator >> targetClasses [
	^ targetClasses
]

{ #category : #accessing }
MPLBatchMethodGenerator >> targetClasses: anObject [
	targetClasses := anObject
]

{ #category : #accessing }
MPLBatchMethodGenerator >> template [
	^ template
]

{ #category : #accessing }
MPLBatchMethodGenerator >> template: anObject [
	template := anObject
]

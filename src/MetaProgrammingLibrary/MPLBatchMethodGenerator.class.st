Class {
	#name : #MPLBatchMethodGenerator,
	#superclass : #MPLAbstractGenerator,
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

{ #category : #generating }
MPLBatchMethodGenerator >> generate [
	self targetClasses do: [ :c |
	(self template substituteParametersWith: (self contextBlock value: c))
		withGeneratedPragma: self withGeneratedPragma;
		installOn: c ]
]

{ #category : #initialization }
MPLBatchMethodGenerator >> initialize [
	super initialize.
	self context: Array empty
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

Class {
	#name : #MPLLegacyBatchMethodGenerator,
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
MPLLegacyBatchMethodGenerator >> context: aDictionary [
	self contextBlock: [ :c | aDictionary ]
]

{ #category : #accessing }
MPLLegacyBatchMethodGenerator >> contextBlock [
	^ contextBlock
]

{ #category : #accessing }
MPLLegacyBatchMethodGenerator >> contextBlock: anObject [
	contextBlock := anObject
]

{ #category : #generating }
MPLLegacyBatchMethodGenerator >> generate [
	self targetClasses do: [ :c |
	|selector|
	selector := c compile: (self template format: (self contextBlock value: c)).
	(c >> selector)
		protocol: self protocol ]
]

{ #category : #initialization }
MPLLegacyBatchMethodGenerator >> initialize [
	super initialize.
	self protocol: Protocol unclassified.
	self context: Array empty
]

{ #category : #accessing }
MPLLegacyBatchMethodGenerator >> protocol [
	^ protocol
]

{ #category : #accessing }
MPLLegacyBatchMethodGenerator >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
MPLLegacyBatchMethodGenerator >> targetClasses [
	^ targetClasses
]

{ #category : #accessing }
MPLLegacyBatchMethodGenerator >> targetClasses: anObject [
	targetClasses := anObject
]

{ #category : #accessing }
MPLLegacyBatchMethodGenerator >> template [
	^ template
]

{ #category : #accessing }
MPLLegacyBatchMethodGenerator >> template: anObject [
	template := anObject
]

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
	|selector|
	selector := c compile: (self template format: (self contextBlock value: c)).
	(c >> selector)
		protocol: self protocol ]
]

{ #category : #initialization }
MPLBatchMethodGenerator >> initialize [
	super initialize.
	self protocol: Protocol unclassified.
	self context: Array empty
]

{ #category : #accessing }
MPLBatchMethodGenerator >> protocol [
	^ protocol
]

{ #category : #accessing }
MPLBatchMethodGenerator >> protocol: anObject [
	protocol := anObject
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

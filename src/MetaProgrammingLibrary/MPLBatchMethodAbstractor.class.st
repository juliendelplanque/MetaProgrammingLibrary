Class {
	#name : #MPLBatchMethodAbstractor,
	#superclass : #MPLAbstractCommand,
	#instVars : [
		'methods',
		'superclass'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #accessing }
MPLBatchMethodAbstractor >> class: aClass protocol: aString [
	^ self methods: (aClass methodsInProtocol: aString)
]

{ #category : #executing }
MPLBatchMethodAbstractor >> execute [
	self methods do: [ :m |
		m asPCGAST
			bodyBlock: [ :body |
				body << (#self asPCGNode receiveMessage: #subclassResponsibility) returnIt ];
			installOn: self superclass ]
]

{ #category : #accessing }
MPLBatchMethodAbstractor >> methods [
	^ methods
]

{ #category : #accessing }
MPLBatchMethodAbstractor >> methods: anObject [
	methods := anObject
]

{ #category : #accessing }
MPLBatchMethodAbstractor >> superclass [
	^ superclass
]

{ #category : #accessing }
MPLBatchMethodAbstractor >> superclass: anObject [
	superclass := anObject
]

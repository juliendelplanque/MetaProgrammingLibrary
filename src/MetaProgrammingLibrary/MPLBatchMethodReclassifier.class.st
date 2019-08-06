Class {
	#name : #MPLBatchMethodReclassifier,
	#superclass : #MPLAbstractCommand,
	#instVars : [
		'classes',
		'newProtocol',
		'selector'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #'instance creation' }
MPLBatchMethodReclassifier class >> classes: classes selector: selector newProtocol: newProtocol [
	<generated>
	^ self new
		classes: classes;
		selector: selector;
		newProtocol: newProtocol;
		yourself
]

{ #category : #accessing }
MPLBatchMethodReclassifier >> classes [
	^ classes
]

{ #category : #accessing }
MPLBatchMethodReclassifier >> classes: anObject [
	classes := anObject
]

{ #category : #executing }
MPLBatchMethodReclassifier >> execute [
	self classes do: [ :class |
		(class includesLocalSelector: self selector)
			ifTrue: [ 
				(class >> self selector)
					protocol: self newProtocol ] ]
]

{ #category : #accessing }
MPLBatchMethodReclassifier >> newProtocol [
	^ newProtocol
]

{ #category : #accessing }
MPLBatchMethodReclassifier >> newProtocol: anObject [
	newProtocol := anObject
]

{ #category : #accessing }
MPLBatchMethodReclassifier >> selector [
	^ selector
]

{ #category : #accessing }
MPLBatchMethodReclassifier >> selector: anObject [
	selector := anObject
]

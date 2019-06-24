Class {
	#name : #MPLFakeClass,
	#superclass : #Object,
	#instVars : [
		'fake1',
		'fake2',
		'fake3'
	],
	#category : #'MetaProgrammingLibrary-Tests'
}

{ #category : #accessing }
MPLFakeClass >> fake1 [
	^ fake1
]

{ #category : #accessing }
MPLFakeClass >> fake1: anObject [
	fake1 := anObject
]

{ #category : #accessing }
MPLFakeClass >> fake2 [
	^ fake2
]

{ #category : #accessing }
MPLFakeClass >> fake2: anObject [
	fake2 := anObject
]

{ #category : #accessing }
MPLFakeClass >> fake3 [
	^ fake3
]

{ #category : #accessing }
MPLFakeClass >> fake3: anObject [
	fake3 := anObject
]

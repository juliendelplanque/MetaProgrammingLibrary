"
A MPLClassDeprecatorTest is a test class for testing the behavior of MPLClassDeprecator
"
Class {
	#name : #MPLClassDeprecatorTest,
	#superclass : #TestCase,
	#category : #'MetaProgrammingLibrary-Tests'
}

{ #category : #running }
MPLClassDeprecatorTest >> tearDown [
	(MPLFakeClass classSide includesLocalSelector: #isDeprecated)
		ifTrue: [ (MPLFakeClass class >> #isDeprecated) removeFromSystem ].
	super tearDown
]

{ #category : #test }
MPLClassDeprecatorTest >> testExecute [
	self deny: MPLFakeClass isDeprecated.
	
	MPLClassDeprecator new
		classToDeprecate: MPLFakeClass;
		execute.
		
	self assert: MPLFakeClass isDeprecated.
]

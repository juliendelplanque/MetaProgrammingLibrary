"
A MPLConstructorGeneratorTest is a test class for testing the behavior of MPLConstructorGenerator
"
Class {
	#name : #MPLConstructorGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'constructorGenerator'
	],
	#category : #'MetaProgrammingLibrary-Tests'
}

{ #category : #running }
MPLConstructorGeneratorTest >> setUp [
	super setUp.
	constructorGenerator := MPLConstructorGenerator new
									targetClass: MPLFakeClass;
									yourself
]

{ #category : #running }
MPLConstructorGeneratorTest >> tearDown [
	(MPLFakeClass class canUnderstand: #fake3:fake2:fake1:)
		ifTrue: [ (MPLFakeClass class >> #fake3:fake2:fake1:) removeFromSystem ].
	super tearDown
]

{ #category : #test }
MPLConstructorGeneratorTest >> testGenerate [
	constructorGenerator
		mutatorSelectors: #(#fake3: #fake2: #fake1:);
		createDummyParameterNames.
	
	constructorGenerator generate.
	
	self assert: (MPLFakeClass class >> #fake3:fake2:fake1:) sourceCode equals: 'fake3: fake3 fake2: fake2 fake1: fake1
	<generated>
	^ self new
		fake3: fake3;
		fake2: fake2;
		fake1: fake1;
		yourself'
]

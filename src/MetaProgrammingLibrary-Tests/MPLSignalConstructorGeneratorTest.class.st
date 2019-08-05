"
A MPLSignalConstructorGeneratorTest is a test class for testing the behavior of MPLSignalConstructorGenerator
"
Class {
	#name : #MPLSignalConstructorGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'signalConstructorGenerator'
	],
	#category : #'MetaProgrammingLibrary-Tests'
}

{ #category : #running }
MPLSignalConstructorGeneratorTest >> setUp [
	super setUp.
	signalConstructorGenerator := MPLSignalConstructorGenerator new
									targetClass: MPLFakeClass;
									yourself
]

{ #category : #running }
MPLSignalConstructorGeneratorTest >> tearDown [
	(MPLFakeClass class canUnderstand: #signalForFake3:fake2:fake1:)
		ifTrue: [ (MPLFakeClass class >> #signalForFake3:fake2:fake1:) removeFromSystem ].
	super tearDown
]

{ #category : #test }
MPLSignalConstructorGeneratorTest >> testExecute [
	signalConstructorGenerator
		mutatorSelectors: #(#fake3: #fake2: #fake1:);
		createDummyParameterNames.
	
	signalConstructorGenerator execute.
	
	self assert: (MPLFakeClass class >> #signalForFake3:fake2:fake1:) sourceCode equals: 'signalForFake3: fake3 fake2: fake2 fake1: fake1
	<generated>
	^ self new
		fake3: fake3;
		fake2: fake2;
		fake1: fake1;
		signal'
]

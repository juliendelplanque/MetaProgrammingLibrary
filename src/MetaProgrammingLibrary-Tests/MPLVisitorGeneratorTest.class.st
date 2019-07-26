"
A MPLVisitorGeneratorTest is a test class for testing the behavior of MPLVisitorGenerator
"
Class {
	#name : #MPLVisitorGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'visitorGenerator'
	],
	#category : #'MetaProgrammingLibrary-Tests'
}

{ #category : #running }
MPLVisitorGeneratorTest >> setUp [
	super setUp.
	visitorGenerator := MPLVisitorGenerator new
									visitorClass: MPLFakeVisitor;
									visitedClasses: { MPLFakeClass. MPLFakeClass2 };
									visitorMethodsProtocol: 'visitor-protocol';
									visitedMethodProtocol: 'visited-protocol';
									yourself
]

{ #category : #running }
MPLVisitorGeneratorTest >> tearDown [
	MPLFakeClass methods
		detect: [ :m | m selector beginsWith: 'accept' ]
		ifFound: #removeFromSystem.
	MPLFakeClass2 methods
		detect: [ :m | m selector beginsWith: 'accept' ]
		ifFound: #removeFromSystem.
	MPLFakeVisitor methods
		detect: [ :m | m selector beginsWith: 'visit' ]
		ifFound: #removeFromSystem.
	super tearDown
]

{ #category : #test }
MPLVisitorGeneratorTest >> testInstallVisitHelperOnVisitor [
	visitorGenerator installVisitHelperOnVisitor.
	
	self assert: (MPLFakeVisitor >> #visit:) sourceCode equals: 'visit: anObject
	<generated>
	^ anObject acceptVisitor: self'.
	self assert: (MPLFakeVisitor >> #visit:) protocol equals: visitorGenerator visitorMethodsProtocol
]

{ #category : #test }
MPLVisitorGeneratorTest >> testInstallVisitedMethodFor [
	visitorGenerator installVisitedMethodFor: MPLFakeClass.
	
	self assert: (MPLFakeClass >> #acceptVisitor:) sourceCode equals: 'acceptVisitor: aMPLFakeVisitor
	<generated>
	^ aMPLFakeVisitor visitMPLFakeClass: self'.
	self assert: (MPLFakeClass >> #acceptVisitor:) protocol equals: visitorGenerator visitedMethodProtocol
]

{ #category : #test }
MPLVisitorGeneratorTest >> testInstallVisitorMethodFor [
	visitorGenerator installVisitorMethodFor: MPLFakeClass.
	
	self assert: (MPLFakeVisitor >> #visitMPLFakeClass:) sourceCode equals: 'visitMPLFakeClass: aMPLFakeClass
	<generated>
	^ self subclassResponsibility'.
	self assert: (MPLFakeVisitor >> #visitMPLFakeClass:) protocol equals: visitorGenerator visitorMethodsProtocol
]

"
A MPLBatchMethodReclassifierTest is a test class for testing the behavior of MPLBatchMethodReclassifier
"
Class {
	#name : #MPLBatchMethodReclassifierTest,
	#superclass : #TestCase,
	#category : #'MetaProgrammingLibrary-Tests'
}

{ #category : #running }
MPLBatchMethodReclassifierTest >> tearDown [
	(MPLFakeClass includesLocalSelector: #methodToReclassify)
		ifTrue: [ (MPLFakeClass >> #methodToReclassify) removeFromSystem ].
	(MPLFakeClass2 includesLocalSelector: #methodToReclassify)
		ifTrue: [ (MPLFakeClass2 >> #methodToReclassify) removeFromSystem ].
	super tearDown
]

{ #category : #test }
MPLBatchMethodReclassifierTest >> testExecute [
	(PCGMethodNode selector: #methodToReclassify)
		bodyBlock: [ :b | ];
		protocol: 'protocol-to-change';
		installOn: MPLFakeClass;
		installOn: MPLFakeClass2.
		
	self assert: (MPLFakeClass >> #methodToReclassify) protocol equals: 'protocol-to-change'.
	self assert: (MPLFakeClass2 >> #methodToReclassify) protocol equals: 'protocol-to-change'.
	
	(MPLBatchMethodReclassifier classes: { MPLFakeClass. MPLFakeClass2 } selector: #methodToReclassify newProtocol: 'new-protocol') execute.
	
	self assert: (MPLFakeClass >> #methodToReclassify) protocol equals: 'new-protocol'.
	self assert: (MPLFakeClass2 >> #methodToReclassify) protocol equals: 'new-protocol'.
]

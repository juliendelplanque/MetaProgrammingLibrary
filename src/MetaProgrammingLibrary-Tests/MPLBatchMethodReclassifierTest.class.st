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
	(MPLFakeClass classSide includesLocalSelector: #methodToReclassify)
		ifTrue: [ (MPLFakeClass class >> #methodToReclassify) removeFromSystem ].
	(MPLFakeClass2 classSide includesLocalSelector: #methodToReclassify)
		ifTrue: [ (MPLFakeClass2 class >> #methodToReclassify) removeFromSystem ].
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

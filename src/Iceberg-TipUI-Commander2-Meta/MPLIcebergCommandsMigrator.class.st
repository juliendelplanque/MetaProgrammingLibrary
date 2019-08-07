Class {
	#name : #MPLIcebergCommandsMigrator,
	#superclass : #MPLAbstractCommand,
	#category : #'Iceberg-TipUI-Commander2-Meta'
}

{ #category : #'as yet unclassified' }
MPLIcebergCommandsMigrator >> clean [
	'Iceberg-TipUI-Commander2' asPackage definedClasses do: [ :c | c removeFromSystem ]
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> execute [
	| originClassMethodTemplate initializeMethodTemplate |
	originClassMethodTemplate := (PCGMethodNode selector: #originClass)
		bodyBlock: [ :body | body << #originClassParam asPCGTemplateParameter returnIt ];
		protocol: 'accessing';
		yourself.
	CmCommand
		subclass: (IceTipCommand name , '2') asSymbol
		slots: {}
		classVariables: {}
		package: 'Iceberg-TipUI-Commander2'.
	IceTipCommand allSubclasses
		do: [ :c | 
			| newClassName |
			newClassName := (c name , '2') asSymbol.
			(self class environment at: (c superclass name , '2') asSymbol)
				subclass: newClassName
				slots: {}
				classVariables: {}
				package: 'Iceberg-TipUI-Commander2'.
			(originClassMethodTemplate
				substituteParametersWith: {(#originClassParam -> c asPCG)} asDictionary)
				installOn:
					(self class environment at: newClassName) classSide ].
	
	initializeMethodTemplate := (PCGMethodNode selector: #initialize)
		bodyBlock: [ :body |
			body << (#super asPCGNode receiveMessage: #initialize).
			body << #initializationCascade asPCGTemplateParameter ];
		protocol: 'initialization';
		yourself.
	
	IceTipCommand2 allSubclassesDo: [ :c |
		|cascade|
		cascade := PCGCascadeNode target: #self asPCGNode.
		([c originClass defaultMenuItemName. true] on: SubclassResponsibility do: [false])
			ifTrue: [ cascade receiveMessage: #basicName: with: c originClass defaultMenuItemName asPCG ].
		([c originClass defaultHelp. true] on: SubclassResponsibility do: [false])
			ifTrue: [ cascade receiveMessage: #basicDescription: with: c originClass defaultHelp asPCG ].
		(initializeMethodTemplate substituteParametersWith: { 
			#initializationCascade -> cascade } asDictionary)
				installOn: c instanceSide ]
]

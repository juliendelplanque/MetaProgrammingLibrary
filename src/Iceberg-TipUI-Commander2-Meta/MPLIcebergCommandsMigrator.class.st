Class {
	#name : #MPLIcebergCommandsMigrator,
	#superclass : #MPLAbstractCommand,
	#category : #'Iceberg-TipUI-Commander2-Meta'
}

{ #category : #executing }
MPLIcebergCommandsMigrator >> asSpecCommandMethodTemplate [
	^ (PCGMethodNode selector: #asSpecCommand)
		bodyBlock: [ :body | 
			body << #conversionCascade asPCGTemplateParameter returnIt ];
		protocol: 'converting';
		yourself
]

{ #category : #cleaning }
MPLIcebergCommandsMigrator >> clean [
	'Iceberg-TipUI-Commander2' asPackage definedClasses do: [ :c | c removeFromSystem ]
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> createAsSpecCommandMethodFor: class [
	| cascade shortcutActivations |
	cascade := PCGCascadeNode target: (#super asPCGNode receiveMessage: #asSpecCommand).
	"Gather the icon name."
	class originClass defaultMenuIconName ifNotNil: [ 
		cascade receiveMessage: #iconName: with: class originClass defaultMenuIconName asPCG ].
	
	"Gather the shortcut and ensure."
	shortcutActivations := class originClass classAnnotations select: [ :activation | activation class = CmdShortcutActivation ].
	self
		assert: (#(0 1) includes: (shortcutActivations collect: #keyCombination) asSet size)
		description: 'All activations must have the same shortcut else we can not decide how to translate to Commander2.'.
	shortcutActivations ifNotEmpty: [
		cascade receiveMessage: #shortcutKey: with: shortcutActivations anyOne keyCombination asPCG ].
	
	cascade messages ifNotEmpty: [
		(self asSpecCommandMethodTemplate substituteParametersWith: { 
			#conversionCascade -> (cascade receiveYourself; yourself) } asDictionary)
				protocol: 'converting';
				installOn: class instanceSide ]
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> createCommander2CommandHierarchy [
	| rootCommandName |
	rootCommandName := (IceTipCommand name , '2') asSymbol.
	CmCommand
		subclass: rootCommandName
		slots: {}
		classVariables: {}
		package: 'Iceberg-TipUI-Commander2'.
	(self class environment at: rootCommandName) comment: CmCommand comment.
	(self originClassMethodTemplate substituteParametersWith: { #originClassParam -> IceTipCommand asPCG })
		installOn: (self class environment at: rootCommandName) classSide.
	IceTipCommand allSubclasses
		do: [ :c | 
			| newClassName |
			newClassName := (c name , '2') asSymbol.
			(self class environment at: (c superclass name , '2') asSymbol)
				subclass: newClassName
				slots: {}
				classVariables: {}
				package: 'Iceberg-TipUI-Commander2'.
			(self class environment at: newClassName) comment: c comment.
			(self originClassMethodTemplate
				substituteParametersWith: {(#originClassParam -> c asPCG)} asDictionary)
				installOn: (self class environment at: newClassName) classSide ]
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> createInitializeMethodFor: class [
	| cascade |
	cascade := PCGCascadeNode target: #self asPCGNode.
	(([ class originClass defaultMenuItemName.
	true ]
		on: SubclassResponsibility
		do: [ false ])
		and: [ class originClass defaultMenuItemName ~= class originClass name ])
		ifTrue: [ cascade
				receiveMessage: #basicName:
				with: class originClass defaultMenuItemName asPCG ].
	([ class originClass defaultHelp.
	true ]
		on: SubclassResponsibility
		do: [ false ])
		ifTrue: [ cascade
				receiveMessage: #basicDescription:
				with: class originClass defaultHelp asPCG ].
	^ cascade messages
		ifNotEmpty: [ (self initializeMethodTemplate
				substituteParametersWith: {(#initializationCascade -> cascade)} asDictionary)
				installOn: class instanceSide ]
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> createisAbstractMethodFor: class [
	(class originClass classSide includesLocalSelector: #isAbstract)
		ifFalse: [ ^ self ].

	(self isAbstractMethodTemplate substituteParametersWith: { #classForComparison -> class asPCG } asDictionary)
			installOn: class classSide
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> execute [
	self createCommander2CommandHierarchy.
	IceTipCommand2 withAllSubclasses do: [ :class | 
			self createInitializeMethodFor: class.
			self createAsSpecCommandMethodFor: class.
			self createisAbstractMethodFor: class ]
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> initializeMethodTemplate [
	^ (PCGMethodNode selector: #initialize)
		bodyBlock: [ :body | 
			body << (#super asPCGNode receiveMessage: #initialize).
			body << #initializationCascade asPCGTemplateParameter ];
		protocol: 'initialization';
		yourself
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> isAbstractMethodTemplate [
	^ (PCGMethodNode selector: #isAbstract)
		bodyBlock: [ :body | 
			body << (#self asPCGNode receiveMessage: #== with: #classForComparison asPCGTemplateParameter) returnIt ];
		protocol: 'accessing';
		yourself
]

{ #category : #executing }
MPLIcebergCommandsMigrator >> originClassMethodTemplate [
	^ (PCGMethodNode selector: #originClass)
		bodyBlock: [ :body | body << #originClassParam asPCGTemplateParameter returnIt ];
		protocol: 'accessing';
		yourself
]

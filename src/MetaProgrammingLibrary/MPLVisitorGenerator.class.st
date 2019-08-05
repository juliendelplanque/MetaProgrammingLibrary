Class {
	#name : #MPLVisitorGenerator,
	#superclass : #MPLAbstractCommand,
	#instVars : [
		'visitor',
		'visited',
		'visitedMethodProtocol',
		'visitorMethodsProtocol',
		'visitedMethodTemplate',
		'visitorMethodTemplate',
		'shouldGenerateMethodInVisitedClasses',
		'visitorClassNameBlock',
		'visitedClassNameBlock'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #default }
MPLVisitorGenerator class >> defaultVisitedMethodProtocol [
	^ 'visiting'
]

{ #category : #default }
MPLVisitorGenerator class >> defaultVisitedMethodTemplate [
	^ (PCGMethodNode selector: #acceptVisitor: arguments: { #visitorParameter asPCGTemplateParameter })
		bodyBlock: [ :body |
			body << (#visitorParameter asPCGTemplateParameter
						receiveMessage: #visitMessageSelector asPCGTemplateParameter
						with: #self asPCGNode) returnIt ]
]

{ #category : #default }
MPLVisitorGenerator class >> defaultVisitorMethodProtocol [
	^ 'visiting'
]

{ #category : #default }
MPLVisitorGenerator class >> defaultVisitorMethodTemplate [
	^ (PCGMethodNode selector: #visitMessageSelector asPCGTemplateParameter arguments: { #visitedParameter asPCGTemplateParameter })
		bodyBlock: [ :body |
			body << (#self asPCGNode receiveMessage: #subclassResponsibility) returnIt ]
]

{ #category : #'instance creation' }
MPLVisitorGenerator class >> visitorClass: anObject1 visitedClasses: anObject2 [ 
	^ self new
		visitorClass: anObject1;
		visitedClasses: anObject2;
		yourself
]

{ #category : #generating }
MPLVisitorGenerator >> compilationContextWith: visitedClass [
	^ {
		'visitorParameter' -> ('a' , (self visitorClassNameBlock value: self visitorClass name)) asSymbol asPCGArgument.
		'visitMessageSelector' -> ('visit' , (self visitedClassNameBlock value: visitedClass name) , ':') asSymbol.
		'visitedParameter' -> ('a' , (self visitedClassNameBlock value: visitedClass name)) asSymbol asPCGArgument
	} asDictionary
]

{ #category : #generating }
MPLVisitorGenerator >> execute [
	self assert: self visitorClass isClass.
	self assert: (self visitedClasses allSatisfy: #isClass).
	self installVisitHelperOnVisitor.
	self visitedClasses do: [ :visitedClass | 
		self shouldGenerateMethodInVisitedClasses
			ifTrue: [ self installVisitedMethodFor: visitedClass ].
		self installVisitorMethodFor: visitedClass ]
]

{ #category : #initialization }
MPLVisitorGenerator >> initialize [
	super initialize.
	self
		visitedMethodProtocol: self class defaultVisitedMethodProtocol;
		visitedMethodTemplate: self class defaultVisitedMethodTemplate;
		visitorMethodsProtocol: self class defaultVisitorMethodProtocol;
		visitorMethodTemplate: self class defaultVisitorMethodTemplate;
		shouldGenerateMethodInVisitedClasses: true;
		visitorClassNameBlock: [ :str | str ];
		visitedClassNameBlock: [ :str | str ]
]

{ #category : #generating }
MPLVisitorGenerator >> installVisitHelperOnVisitor [
	(PCGMethodNode selector: #visit: arguments: { #anObject asPCGArgument })
		bodyBlock: [ :body |
			body << (#anObject asPCGArgument
						receiveMessage: self visitedMethodTemplate selector
						with: #self asPCGNode) returnIt ];
		protocol: self visitorMethodsProtocol;
		withGeneratedPragma: self withGeneratedPragma;
		installOn: self visitorClass
]

{ #category : #generating }
MPLVisitorGenerator >> installVisitedMethodFor: visitedClass [
	(self visitedMethodTemplate substituteParametersWith: (self compilationContextWith: visitedClass))
		protocol: self visitedMethodProtocol;
		withGeneratedPragma: self withGeneratedPragma;
		installOn: visitedClass
]

{ #category : #generating }
MPLVisitorGenerator >> installVisitorMethodFor: visitedClass [
	(self visitorMethodTemplate substituteParametersWith: (self compilationContextWith: visitedClass))
		protocol: self visitorMethodsProtocol;
		withGeneratedPragma: self withGeneratedPragma;
		installOn: self visitorClass
]

{ #category : #accessing }
MPLVisitorGenerator >> shouldGenerateMethodInVisitedClasses [
	^ shouldGenerateMethodInVisitedClasses
]

{ #category : #accessing }
MPLVisitorGenerator >> shouldGenerateMethodInVisitedClasses: anObject [
	shouldGenerateMethodInVisitedClasses := anObject
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedClassNameBlock [
	^ visitedClassNameBlock
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedClassNameBlock: anObject [
	visitedClassNameBlock := anObject
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedClasses [
	^ visited
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedClasses: anObject [
	visited := anObject
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedMethodProtocol [
	^ visitedMethodProtocol
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedMethodProtocol: anObject [
	visitedMethodProtocol := anObject
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedMethodTemplate [
	^ visitedMethodTemplate
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedMethodTemplate: anObject [
	visitedMethodTemplate := anObject
]

{ #category : #accessing }
MPLVisitorGenerator >> visitorClass [
	^ visitor
]

{ #category : #accessing }
MPLVisitorGenerator >> visitorClass: anObject [
	visitor := anObject
]

{ #category : #accessing }
MPLVisitorGenerator >> visitorClassNameBlock [
	^ visitorClassNameBlock
]

{ #category : #accessing }
MPLVisitorGenerator >> visitorClassNameBlock: anObject [
	visitorClassNameBlock := anObject
]

{ #category : #accessing }
MPLVisitorGenerator >> visitorMethodTemplate [
	^ visitorMethodTemplate
]

{ #category : #accessing }
MPLVisitorGenerator >> visitorMethodTemplate: anObject [
	visitorMethodTemplate := anObject
]

{ #category : #accessing }
MPLVisitorGenerator >> visitorMethodsProtocol [
	^ visitorMethodsProtocol
]

{ #category : #accessing }
MPLVisitorGenerator >> visitorMethodsProtocol: anObject [
	visitorMethodsProtocol := anObject
]

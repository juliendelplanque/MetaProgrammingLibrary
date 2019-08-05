Class {
	#name : #MPLLegacyVisitorGenerator,
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
	#category : #'MetaProgrammingLibrary-Legacy'
}

{ #category : #default }
MPLLegacyVisitorGenerator class >> defaultVisitedMethodProtocol [
	^ 'visiting'
]

{ #category : #default }
MPLLegacyVisitorGenerator class >> defaultVisitedMethodTemplate [
	^ 'acceptVisitor: a{visitorClassName}
	^ a{visitorClassName} visit{visitedClassName}: self'
]

{ #category : #default }
MPLLegacyVisitorGenerator class >> defaultVisitorMethodProtocol [
	^ 'visiting'
]

{ #category : #default }
MPLLegacyVisitorGenerator class >> defaultVisitorMethodTemplate [
	^ 'visit{visitedClassName}: a{visitedClassName}
	^ self subclassResponsibility'
]

{ #category : #'instance creation' }
MPLLegacyVisitorGenerator class >> visitorClass: anObject1 visitedClasses: anObject2 [ 
	^ self new
		visitorClass: anObject1;
		visitedClasses: anObject2;
		yourself
]

{ #category : #generating }
MPLLegacyVisitorGenerator >> compilationContextWith: visitedClass [
	^ {
		('visitorClassName' -> (self visitorClassNameBlock value: self visitorClass name)).
		('visitedClassName' -> (self visitedClassNameBlock value: visitedClass name))
	} asDictionary
]

{ #category : #generating }
MPLLegacyVisitorGenerator >> execute [
	| selector |
	self assert: self visitorClass isClass.
	self assert: (self visitedClasses allSatisfy: #isClass).
	
	selector := self visitorClass compile: 'visit: anObject
	^ anObject acceptVisitor: self'.
	(self visitorClass >> selector)
		protocol: self visitorMethodsProtocol.
	
	self visitedClasses do: [ :visitedClass |
		self shouldGenerateMethodInVisitedClasses ifTrue: [
			(self visitedMethodForVisited: visitedClass)
				protocol: self visitedMethodProtocol;
				installOn: visitedClass ].
		selector := self visitorClass compile: (self visitorMethodForVisited: visitedClass).
		(self visitorClass >> selector)
			protocol: self visitorMethodsProtocol ]
]

{ #category : #initialization }
MPLLegacyVisitorGenerator >> initialize [
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

{ #category : #accessing }
MPLLegacyVisitorGenerator >> shouldGenerateMethodInVisitedClasses [
	^ shouldGenerateMethodInVisitedClasses
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> shouldGenerateMethodInVisitedClasses: anObject [
	shouldGenerateMethodInVisitedClasses := anObject
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitedClassNameBlock [
	^ visitedClassNameBlock
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitedClassNameBlock: anObject [
	visitedClassNameBlock := anObject
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitedClasses [
	^ visited
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitedClasses: anObject [
	visited := anObject
]

{ #category : #generating }
MPLLegacyVisitorGenerator >> visitedMethodForVisited: visitedClass [
	^ self visitedMethodTemplate format: (self compilationContextWith: visitedClass)
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitedMethodProtocol [
	^ visitedMethodProtocol
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitedMethodProtocol: anObject [
	visitedMethodProtocol := anObject
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitedMethodTemplate [
	^ visitedMethodTemplate
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitedMethodTemplate: anObject [
	visitedMethodTemplate := anObject
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitorClass [
	^ visitor
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitorClass: anObject [
	visitor := anObject
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitorClassNameBlock [
	^ visitorClassNameBlock
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitorClassNameBlock: anObject [
	visitorClassNameBlock := anObject
]

{ #category : #generating }
MPLLegacyVisitorGenerator >> visitorMethodForVisited: visitedClass [
	^ self visitorMethodTemplate format: (self compilationContextWith: visitedClass)
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitorMethodTemplate [
	^ visitorMethodTemplate
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitorMethodTemplate: anObject [
	visitorMethodTemplate := anObject
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitorMethodsProtocol [
	^ visitorMethodsProtocol
]

{ #category : #accessing }
MPLLegacyVisitorGenerator >> visitorMethodsProtocol: anObject [
	visitorMethodsProtocol := anObject
]

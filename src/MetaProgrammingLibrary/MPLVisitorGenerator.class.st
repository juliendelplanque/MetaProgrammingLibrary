Class {
	#name : #MPLVisitorGenerator,
	#superclass : #MPLAbstractGenerator,
	#instVars : [
		'visitor',
		'visited',
		'visitedMethodProtocol',
		'visitorMethodsProtocol',
		'visitedMethodTemplate',
		'visitorMethodTemplate',
		'shouldGenerateMethodInVisitedClasses'
	],
	#category : #MetaProgrammingLibrary
}

{ #category : #default }
MPLVisitorGenerator class >> defaultVisitedMethodProtocol [
	^ 'visiting'
]

{ #category : #default }
MPLVisitorGenerator class >> defaultVisitedMethodTemplate [
	^ 'acceptVisitor: a{visitorClassName}
	^ a{visitorClassName} visit{visitedClassName}: self'
]

{ #category : #default }
MPLVisitorGenerator class >> defaultVisitorMethodProtocol [
	^ 'visiting'
]

{ #category : #default }
MPLVisitorGenerator class >> defaultVisitorMethodTemplate [
	^ 'visit{visitedClassName}: a{visitedClassName}
	^ self subclassResponsibility'
]

{ #category : #'instance creation' }
MPLVisitorGenerator class >> visitorClass: anObject1 visitedClasses: anObject2 [ 
	^ self new
		visitorClass: anObject1;
		visitedClasses: anObject2;
		yourself
]

{ #category : #generating }
MPLVisitorGenerator >> generate [
	| selector |
	self assert: self visitorClass isClass.
	self assert: (self visitedClasses allSatisfy: #isClass).
	
	selector := self visitorClass compile: 'visit: anObject
	^ anObject acceptVisitor: self'.
	(self visitorClass >> selector)
		protocol: self visitorMethodsProtocol.
	
	self visitedClasses do: [ :visitedClass |
		self shouldGenerateMethodInVisitedClasses ifTrue: [
			selector := visitedClass compile: (self visitedMethodForVisited: visitedClass).
			(visitedClass >> selector)
				protocol: self visitedMethodProtocol ].
		selector := self visitorClass compile: (self visitorMethodForVisited: visitedClass).
		(self visitorClass >> selector)
			protocol: self visitorMethodsProtocol ]
]

{ #category : #initialization }
MPLVisitorGenerator >> initialize [
	super initialize.
	self
		visitedMethodProtocol: self class defaultVisitedMethodProtocol;
		visitedMethodTemplate: self class defaultVisitedMethodTemplate;
		visitorMethodsProtocol: self class defaultVisitorMethodProtocol;
		visitorMethodTemplate: self class defaultVisitorMethodTemplate;
		shouldGenerateMethodInVisitedClasses: true
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
MPLVisitorGenerator >> visitedClasses [
	^ visited
]

{ #category : #accessing }
MPLVisitorGenerator >> visitedClasses: anObject [
	visited := anObject
]

{ #category : #generating }
MPLVisitorGenerator >> visitedMethodForVisited: visitedClass [
	^ self visitedMethodTemplate format: { 
		'visitorClassName' -> self visitorClass name.
		'visitedClassName' -> visitedClass name } asDictionary
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

{ #category : #generating }
MPLVisitorGenerator >> visitorMethodForVisited: visitedClass [
	^ self visitorMethodTemplate format: { 
		'visitorClassName' -> self visitorClass name.
		'visitedClassName' -> visitedClass name } asDictionary
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

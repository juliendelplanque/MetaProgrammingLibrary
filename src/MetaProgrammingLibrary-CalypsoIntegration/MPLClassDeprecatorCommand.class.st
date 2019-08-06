Class {
	#name : #MPLClassDeprecatorCommand,
	#superclass : #MPLClassCommand,
	#category : #'MetaProgrammingLibrary-CalypsoIntegration'
}

{ #category : #accessing }
MPLClassDeprecatorCommand >> defaultMenuItemName [
	^ 'Deprecate'
]

{ #category : #accessing }
MPLClassDeprecatorCommand >> pcgAstForWorkspace [
	^ (PCGCascadeNode target: (MPLClassDeprecator asPCG receiveMessage: #new))
			receiveMessage: #classToDeprecate: with: self targetClass asPCG;
			receiveMessage: #execute;
			yourself
]

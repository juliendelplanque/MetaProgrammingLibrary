Class {
	#name : #MPLSignalConstructorGeneratorCommand,
	#superclass : #MPLConstructorGeneratorCommand,
	#category : #'MetaProgrammingLibrary-CalypsoIntegration'
}

{ #category : #execution }
MPLSignalConstructorGeneratorCommand >> defaultMenuItemName [
	^ 'Generate signalFor constructor'
]

{ #category : #accessing }
MPLSignalConstructorGeneratorCommand >> pcgAstForWorkspace [
	^ super pcgAstForWorkspace in: [ :ast |
		ast target: (MPLSignalConstructorGenerator asPCG receiveMessage: #new).
		ast ]
]

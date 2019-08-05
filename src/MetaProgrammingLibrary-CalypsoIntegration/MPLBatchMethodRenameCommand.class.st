Class {
	#name : #MPLBatchMethodRenameCommand,
	#superclass : #MPLMethodCommand,
	#category : #'MetaProgrammingLibrary-CalypsoIntegration'
}

{ #category : #activation }
MPLBatchMethodRenameCommand class >> methodMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuActivation byItemOf: MPLMenuGroup for: ClyMethod asCalypsoItemContext 
]

{ #category : #accessing }
MPLBatchMethodRenameCommand >> defaultMenuItemName [
	^ 'Batch rename'
]

{ #category : #accessing }
MPLBatchMethodRenameCommand >> pcgAstForWorkspace [
	^ (PCGCascadeNode target: (MPLBatchMethodRename asPCG receiveMessage: #new))
			receiveMessage: #methods: with: self methods asPCG;
			receiveMessage: #oldSubstring: with: '' asPCG;
			receiveMessage: #newSubstring: with: '' asPCG;
			receiveMessage: #useBeginsWith;
			receiveMessage: #execute;
			yourself
]

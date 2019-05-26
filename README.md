# MetaProgrammingLibrary
A library to generate / transform Pharo code.

## Batch class renaming

```st
MPLBatchClassesPrefixRename new
	classes: {ABClass1 . ABClass2. ABClass3};
	oldPrefix: 'AB';
	newPrefix: 'DE';
	generate
```

Will rename `ABClass1, ABClass2, ABClass3` as respectively `DEClass1 . DEClass2. DEClass3`.

## Constructor generator

```st
MPLConstructorGenerator new
	targetClass: Person;
	mutatorSelectors: { #name:. #age: };
	createDummyParameterNames;
	generate.
```

Will generate the following method:

```st
Person class>>name: name age: age
	^ self new
		name: name;
		age: age;
		yourself
```

## Visitor design pattern

```st
MPLVisitorGenerator new
	visitorClass: VisitorClass;
	visitedClasses: { VisitedClass1 . VisitedClass2 . VisitedClass3 };
	generate.
```

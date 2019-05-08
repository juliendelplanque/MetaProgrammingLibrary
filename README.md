# DesignPatternGenerator
A framework to generate template Pharo code for design pattern.

## Visitor design pattern

```st
DPGVisitorGenerator new
	visitorClass: ClassToBeVisited;
	visitedClasses: { VisitedClass1 . VisitedClass2 . VisitedClass3 };
	generate.
```

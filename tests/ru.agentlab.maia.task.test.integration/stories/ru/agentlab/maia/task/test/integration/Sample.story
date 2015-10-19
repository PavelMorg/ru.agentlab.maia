Execution order with different scheduler types

Narrative:
In order to effectively execute task tree
As a task designer
I want to control execution order by using different schedulers with different types

Scenario: Executing sequential scheduler with parallel subtasks
Given a sequential schedulers A
And a parallel schedulers B, C
And a primitive tasks B1, B2, B3, B4, C1, C2, C3, C4
And task A have subtasks B, C
And task B have subtasks B1, B2, B3, B4
And task C have subtasks C1, C2, C3, C4
When execute task A by 8 times
Then execution order is B1, B2, B3, B4, C1, C2, C3, C4
And task A have SUCCESS state

Scenario: Executing sequential scheduler with sequential subtasks
Given a sequential schedulers A, B, C
And a primitive tasks B1, B2, B3, B4, C1, C2, C3, C4
And task A have subtasks B, C
And task B have subtasks B1, B2, B3, B4
And task C have subtasks C1, C2, C3, C4
When execute task A by 8 times
Then execution order is B1, B2, B3, B4, C1, C2, C3, C4
And task A have SUCCESS state

Scenario: Executing parallel scheduler with sequential subtasks
Given a parallel schedulers A
And a sequential schedulers B, C
And a primitive tasks B1, B2, B3, B4, C1, C2, C3, C4
And task A have subtasks B, C
And task B have subtasks B1, B2, B3, B4
And task C have subtasks C1, C2, C3, C4
When execute task A by 8 times
Then execution order is B1, C1, B2, C2, B3, C3, B4, C4
And task A have SUCCESS state

Scenario: Executing parallel scheduler with parallel subtasks
Given a parallel schedulers A, B, C
And a primitive tasks B1, B2, B3, B4, C1, C2, C3, C4
And task A have subtasks B, C
And task B have subtasks B1, B2, B3, B4
And task C have subtasks C1, C2, C3, C4
When execute task A by 8 times
Then execution order is B1, C1, B2, C2, B3, C3, B4, C4
And task A have SUCCESS state
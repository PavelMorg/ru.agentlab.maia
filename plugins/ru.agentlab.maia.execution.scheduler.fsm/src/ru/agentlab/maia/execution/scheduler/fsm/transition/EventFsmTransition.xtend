package ru.agentlab.maia.execution.scheduler.fsm.transition

import ru.agentlab.maia.execution.tree.IExecutionNode

class EventFsmTransition extends AbstractFsmTransition {

	new(String name, IExecutionNode from, IExecutionNode to) {
		super(name, from, to)
	}

}
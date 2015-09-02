package ru.agentlab.maia.execution.scheduler.fsm.transition

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.tree.IExecutionNode

@Accessors
abstract class AbstractFsmTransition implements IFsmTransition {

	String name

	IExecutionNode from

	IExecutionNode to

	new(String name, IExecutionNode from, IExecutionNode to) {
		this.name = name
		this.from = from
		this.to = to
	}

}
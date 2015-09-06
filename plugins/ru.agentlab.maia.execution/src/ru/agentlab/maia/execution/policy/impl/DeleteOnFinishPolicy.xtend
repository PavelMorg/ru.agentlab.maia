package ru.agentlab.maia.execution.policy.impl

import ru.agentlab.maia.execution.policy.ISchedulingFinishPolicy
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler
import ru.agentlab.maia.memory.IMaiaContext

class DeleteOnFinishPolicy implements ISchedulingFinishPolicy {

	override onEnd(IMaiaContext context, IExecutionScheduler scheduler) {
		context.remove(IExecutionNode)
	}

}
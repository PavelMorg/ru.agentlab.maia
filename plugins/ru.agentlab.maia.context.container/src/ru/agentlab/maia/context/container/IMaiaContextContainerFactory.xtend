package ru.agentlab.maia.context.container

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaContextContainerFactory {

	def IMaiaContext createContainer(IMaiaContext parentContext)

}
#pragma once

#include "engine/core/main/module.h"

namespace Echo
{
	class SlamModule : public Module
	{
		ECHO_SINGLETON_CLASS(SlamModule, Module)

	public:
		SlamModule();
		virtual ~SlamModule();

		// instance
		static SlamModule* instance();

		// register all types of the module
		virtual void registerTypes() override;

	protected:
	};
}

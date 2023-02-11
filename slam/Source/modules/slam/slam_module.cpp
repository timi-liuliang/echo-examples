#include "slam_module.h"

namespace Echo
{
	DECLARE_MODULE(SlamModule, __FILE__)

	SlamModule::SlamModule()
	{

	}

	SlamModule::~SlamModule()
	{
	}

	SlamModule* SlamModule::instance()
	{
		static SlamModule* inst = EchoNew(SlamModule);
		return inst;
	}

	void SlamModule::bindMethods()
	{
	}

	void SlamModule::registerTypes()
	{
	}
}

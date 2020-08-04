/**
 * @description This utility class it for allowing the process builder to bypass a trigger that utilizes the TriggerHandler framework. Pass it the name of the trigger handler to bypass it.
 * @author Matt Gerry
 * @date 06/05/2020.
 */

public with sharing class Util_Process_Builder_Trigger_Bypass
{
	@InvocableMethod(label = 'Process Builder Trigger Bypass' description = 'Invocable method used to stop triggers from running when process builder insert or update actions occur')
	public static void stopTriggers(List<String> triggerHandlerName)
	{
		TriggerHandler.bypass(triggerHandlerName[0]);
	}
}
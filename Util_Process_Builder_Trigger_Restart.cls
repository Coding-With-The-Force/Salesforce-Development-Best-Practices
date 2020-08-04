/**
 * @description This utility class it for allowing the process builder to restart a trigger that utilizes the TriggerHandler framework. Pass it the name of the trigger handler to restart it.
 * @author Matt Gerry
 * @date 07/02/2020.
 */
public with sharing class Util_Process_Builder_Trigger_Restart
{
	@InvocableMethod(label = 'Process Builder Trigger Restart' description = 'Invocable method used to allow triggers to fire again')
	public static void startTriggers(List<String> triggerHandlerName)
	{
		TriggerHandler.clearBypass(triggerHandlerName[0]);
	}
}
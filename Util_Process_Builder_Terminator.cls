/**
 * @description This utility class it used to terminate process builders when necessary. To my knowledge this is the cleanest way to exit a process builder.
 * @author Matt Gerry
 * @date 06/05/2020.
 */

public with sharing class Util_Process_Builder_Terminator
{
	@InvocableMethod(Label='Terminate Process Builder' Description='Terminate Process Builder')
	public static void terminateProcessBuilder() {}
}
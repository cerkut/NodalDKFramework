classdef preampPlugin < audioPlugin
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Gain = 50;
        Output = 50;
    end
    
    properties (Access = private)
       preamp 
    end
    
    properties (Constant)
        PluginInterface = audioPluginInterface (...
            audioPluginParameter('Gain',  'Mapping',{'lin',0,100},'Label', '%'), ...
            audioPluginParameter('Output','Mapping',{'lin',0,100},'Label', '%'))
    end
    
    methods
        %% Contructor
        function plugin = preampPlugin()
            plugin.preamp = preampModel(plugin.getSampleRate);
        end
        %% PROCESS
       function out = process(plugin, in)
            [sig, ~] = plugin.preamp.process(in*plugin.Gain*0.01);
            out = sig*plugin.Output*0.01;
       end 
       
       %% RESET
       function reset(plugin)
            plugin.preamp = preampModel(plugin.getSampleRate);
       end
       
       %% ASSESSORS
       function set.Gain(plugin, val)
          plugin.Gain = val; 
       end
       
       function set.Output(plugin, val)
          plugin.Output = val; 
       end
    end
    
end


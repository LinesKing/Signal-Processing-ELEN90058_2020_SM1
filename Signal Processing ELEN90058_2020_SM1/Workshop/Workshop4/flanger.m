classdef flanger < matlab.System
    properties(Nontunable)
        BlockSize = 40000; 
        SampleRate = 8000;
        w = pi/8000;
        Delay = 80;
        Alpha = 0.7;
        n = 0:5*8000-1;
    end
    
    properties(Access=private)
        DelayBuffer;
        dn;
    end
    
    methods
        function obj = flanger(varargin)
            setProperties(obj,nargin,varargin{:});
        end
    end
    methods (Access=protected)
        function setupImpl(obj)
            obj.DelayBuffer = dsp.AsyncBuffer(obj.Delay+obj.BlockSize) ;
            write(obj.DelayBuffer,zeros(obj.Delay,1)) ;
        end
        function y = stepImpl(obj, audio_in)
            write(obj.DelayBuffer,audio_in);
%             x_delay = read(obj.DelayBuffer,length(audio_in));
            obj.dn = round(obj.Delay .* (1-cos(obj.w .* obj.n)));
            for i = 1:39922
                if obj.dn(i) >= i
                    obj.dn(i) = i-1;
                end
                y(i) = audio_in(i) + obj.Alpha * audio_in(i-obj.dn(i));
            end
%             y = audio_in+obj.Alpha.*audio_in(x_delay);
        end
        function resetImpl(obj) % Initialize / reset discrete-state properties

        end
    end
end


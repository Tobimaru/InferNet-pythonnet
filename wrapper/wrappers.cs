using System;

using Mod = Microsoft.ML.Probabilistic.Models;

namespace InferWrapper
{
    public static class Variable
    {
        public static Mod.VariableArray<T> Observed<T>(T[] arr)
        {
            return Mod.Variable.Observed(arr);
        }
    }
}

using Microsoft.AspNetCore.Mvc;
using System;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace TestEnvVar.Controllers
{
    [ApiController]
    public class TestController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<TestController> _logger;

        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };


        public TestController(IConfiguration configuration, ILogger<TestController> logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        [HttpGet("name")]
        public string Get()
        {
            var rng = new Random();
            this._logger.LogWarning($"Num is {rng.Next(1,100)}");
            return _configuration["AppName"];
        }
    }
}

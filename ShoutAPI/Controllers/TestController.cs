using Microsoft.AspNetCore.Mvc;
using ShoutAPI.Database.Models;
using ShoutAPI.Services;

namespace ShoutAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TestController : ControllerBase
    {

        private readonly TestService _testService;

        public TestController(TestService _tService)
        {
            _testService = _tService;
        }

        [HttpGet("first")]
        public IActionResult GetFirst()
        {
            try
            {
                var user = _testService.GetFirstTestEntry();
                if (user != null)
                    return Ok(user);
                else
                    return BadRequest("No test user found.");
            }
            catch(Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);
            }
        }

        [HttpGet("last")]
        public IActionResult GetLast()
        {
            try
            {
                var user = _testService.GetLastTestEntry();
                if (user != null)
                    return Ok(user);
                else
                    return BadRequest("No test user found.");
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);
            }
        }

        [HttpGet("")]
        public IActionResult GetAll()
        {
            try
            {
                var res = _testService.GetTestEntries();
                if(res.Item1 != 200)
                    return StatusCode(res.Item1, res.Item2);
                return Ok(res.Item2);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);
            }
        }



        [HttpPost]
        public IActionResult Post(TestModel model)  {
            var res = _testService.AddTestEntry(model);
            return StatusCode(res.Item1, res.Item2);
        }
    }
}

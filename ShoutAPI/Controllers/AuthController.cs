using Microsoft.AspNetCore.Mvc;
using ShoutAPI.Services;
using static ShoutAPI.Database.Models.Records;

namespace ShoutAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly AuthService _authService;

        public AuthController(AuthService aService)
        {
            _authService = aService;
        }

        [HttpPost("login")]
        public IActionResult LoginUser(LoginRecord loginData)
        {
            var validated = _authService.CheckCredentials(loginData);
            return validated switch
            {
                -2 => StatusCode(500, "Server error"),
                -1 => BadRequest("Invalid username/password"),
                0 => BadRequest("Invalid username/password"),
                1 => Ok("Success!"),
                _ => BadRequest("Invalid username or password."),
            };
        }

        [HttpPost("register")]
        public IActionResult RegisterUser(NewUserRecord registrationData)
        {
            var registrationStatus = _authService.RegisterUser(registrationData);

            return registrationStatus switch
            {
                -2 => StatusCode(500, "Server error"),
                -1 => BadRequest("Username already exists"),
                0 => Ok("Success!"),
                _ => BadRequest("Unknown error"),
            };
        }
    }
}

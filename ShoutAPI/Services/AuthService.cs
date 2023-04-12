using ShoutAPI.Database;
using static ShoutAPI.Database.Models.Records;

namespace ShoutAPI.Services
{
    [RegisterScoped]
    public class AuthService
    {
        private readonly DatabaseContext _dbContext;

        public AuthService(DatabaseContext dataContext)
        {
            _dbContext = dataContext;
        }

        public int CheckCredentials(LoginRecord loginData)
        {
            try
            {
                var registrationTable = _dbContext.Registration.OrderBy(x => x.Id);

                // Search if the user exists in the registration table
                var user = registrationTable.FirstOrDefault(x => x.Username.Equals(loginData.Username));
                if (user is null)
                    return -1; // If the user does not exist, return bad username

                var validated = BCrypt.Net.BCrypt.Verify(loginData.Password, user.Password);
                if (validated)
                    return 1; // Return success if the hashed password matches the provided password
                return 0; // Otherwise return bad password
            }
            catch(Exception e)
            {
                Console.WriteLine(e.StackTrace);
                return -2;
            }

        }

        public int RegisterUser(NewUserRecord newUser)
        {
            try
            {
                var registrationTable = _dbContext.Registration.OrderBy(x => x.Id);

                // Check if that username already exists within our registered users
                if (registrationTable.Any(x => x.Username.Equals(newUser.Username)))
                    return -1; // If the user exists return that it already exists

                // Create a salt and hash their password
                var salt = BCrypt.Net.BCrypt.GenerateSalt(5);
                var hashedPassword = BCrypt.Net.BCrypt.HashPassword(newUser.Password, salt);

                // Create a new registration record using the new user data
                var registrationUser = new RegistrationRecord()
                {
                    Username = newUser.Username,
                    Password = hashedPassword,
                    PhoneNumber = newUser.PhoneNumber,
                    DateRegistered = DateTime.UtcNow.ToString("o"),
                    ClientId = null,
                    Salt = salt,
                    Id = default
                };

                // Add the registration user record to the table
                _dbContext.Registration.Add(registrationUser);
                _dbContext.SaveChanges();

                return 0; // Return success
            }
            catch(Exception e)
            {
                Console.WriteLine(e.StackTrace);
                return -2;
            }
        }
    }
}

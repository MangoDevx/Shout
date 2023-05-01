using FirebaseAdmin;
using FirebaseAdmin.Messaging;
using Google.Apis.Auth.OAuth2;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

var googleCredential = builder.Configuration["ConnectionStrings:GoogleCred"];


var firebaseApp = FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.FromJson(googleCredential)
});


app.MapGet("/test", async () =>
{
    var message = new Message()
    {
        Topic = "shout",
        Data = new Dictionary<string, string>() 
        {
            {"username", "Test User" },
            {"body", "This is a test from the api!" },
        }
    };

    var msg = await FirebaseMessaging.DefaultInstance.SendAsync(message);
    Console.WriteLine("Fired!, " + msg ?? "null");
})
.WithName("testNotification");

app.MapPost("/newmsg", async (AppMessage msg) =>
{
    var replyMessage = new Message()
    {
        Topic = "shout",
        Data = new Dictionary<string, string>()
        {
            {"username", msg.Username },
            {"body", msg.Body }
        }
    };

    var response = await FirebaseMessaging.DefaultInstance.SendAsync(replyMessage);
    Console.WriteLine("Fired!, " + response ?? "null");
})
.WithOpenApi();

app.Run();

internal class AppMessage
{
    public required string Username { get; set;}
    public required string Body { get; set; }
}


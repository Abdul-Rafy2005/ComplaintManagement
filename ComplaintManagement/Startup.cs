using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ComplaintManagement.Startup))]
namespace ComplaintManagement
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

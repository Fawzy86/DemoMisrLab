using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DemoMisrInternationalLab.Startup))]
namespace DemoMisrInternationalLab
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

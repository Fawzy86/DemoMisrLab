//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DemoMisrInternationalLab.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Entity
    {
        public Entity()
        {
            this.Permissions = new HashSet<Permission>();
        }
    
        public int EntityID { get; set; }
        public string EntityName { get; set; }
        public string EntityDescription { get; set; }
    
        public virtual ICollection<Permission> Permissions { get; set; }
    }
}

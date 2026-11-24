"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { Globe, Map, Camera, Plane, User } from "lucide-react";
import { cn } from "@/lib/utils";

const mobileNavItems = [
  { href: "/dashboard", label: "Home", icon: Globe },
  { href: "/map", label: "Map", icon: Map },
  { href: "/memories", label: "Memories", icon: Camera },
  { href: "/trips", label: "Trips", icon: Plane },
  { href: "/profile", label: "Profile", icon: User },
];

export function MobileNav() {
  const pathname = usePathname();

  return (
    <nav className="lg:hidden fixed bottom-0 left-0 right-0 z-50 bg-sidebar-background border-t border-sidebar-border">
      <div className="flex items-center justify-around h-16 px-2 max-w-lg mx-auto">
        {mobileNavItems.map((item) => {
          const isActive =
            pathname === item.href || pathname.startsWith(item.href + "/");
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex flex-col items-center justify-center gap-1 w-16 h-full text-[10px] font-medium transition-colors",
                isActive
                  ? "text-primary"
                  : "text-muted-foreground hover:text-foreground"
              )}
            >
              <item.icon
                className={cn("w-5 h-5", isActive && "text-primary")}
              />
              {item.label}
            </Link>
          );
        })}
      </div>
    </nav>
  );
}

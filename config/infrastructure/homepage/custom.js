(() => {
  "use strict";

  const text = (value) => document.createTextNode(value);

  const createChip = (label, className = "noc-status-chip") => {
    const chip = document.createElement("span");
    chip.className = className;
    chip.append(text(label));
    return chip;
  };

  const start = () => {
    if (document.querySelector(".noc-command-header")) return;

    const mount = document.querySelector("main") || document.body;
    const header = document.createElement("section");
    header.className = "noc-command-header";
    header.setAttribute("aria-label", "Command center status");

    const title = document.createElement("div");
    const eyebrow = document.createElement("p");
    eyebrow.className = "noc-eyebrow";
    eyebrow.append(text("OSIER HOMELAB / NETWORK OPERATIONS"));
    const heading = document.createElement("h1");
    heading.append(text("COMMAND CENTER"));
    title.append(eyebrow, heading);

    const status = document.createElement("div");
    status.className = "noc-status-cluster";
    status.append(createChip("SYSTEMS ONLINE"), createChip("DOCKER LINKED"));
    header.append(title, status);
    mount.prepend(header);

    const footer = document.createElement("footer");
    footer.className = "noc-command-footer";
    const label = document.createElement("span");
    label.className = "noc-footer-label";
    label.append(text("OSIER // NOC"));
    const details = document.createElement("div");
    details.className = "noc-footer-details";
    const runtime = document.createElement("span");
    const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
    details.append(runtime, createChip(`LOCAL TIME / ${timezone}`));
    footer.append(label, details);
    mount.append(footer);

    const renderRuntime = () => {
      runtime.textContent = `CONSOLE TIME / ${new Intl.DateTimeFormat("en-US", {
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
        hour12: false,
      }).format(new Date())}`;
    };

    renderRuntime();
    window.setInterval(renderRuntime, 1000);
  };

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", start, { once: true });
  } else {
    start();
  }
})();

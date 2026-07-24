<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Top Loading Bar - Minimal Gray -->
<style>
/* Minimal Gray Loading Bar */
#nprogress {
    pointer-events: none;
}

#nprogress .bar {
    background: linear-gradient(90deg, #374151, #4b5563, #6b7280);
    position: fixed;
    z-index: 999999;
    top: 0;
    left: 0;
    width: 0%;
    height: 3px;
    box-shadow: 0 0 8px rgba(55, 65, 81, 0.4);
    transition: width 0.4s ease, opacity 0.4s ease;
}

#nprogress .peg {
    display: block;
    position: absolute;
    right: 0px;
    width: 100px;
    height: 100%;
    box-shadow: 0 0 8px #4b5563;
    opacity: 1.0;
    transform: rotate(3deg) translate(0px, -4px);
}

/* FORCE HIDE any other loading bars/borders */
.header {
    border-bottom: none !important;
}
.header::before, .header::after {
    display: none !important;
}
.pagetitle, .breadcrumb {
    border-bottom: none !important;
}
/* Hide NiceAdmin default progress/loading elements */
.progress, .loading-bar, [class*="loading"], [class*="progress-bar"] {
    display: none !important;
}
/* NUCLEAR: Hide ALL cyan colored elements */
*[style*="background-color: rgb(6, 182, 212)"],
*[style*="background-color:#06b6d4"],
*[style*="background: rgb(6, 182, 212)"],
*[style*="background:#06b6d4"],
*[style*="border-color: rgb(6, 182, 212)"],
*[style*="border-color:#06b6d4"] {
    display: none !important;
}
/* Hide pseudo-elements with cyan */
*::before[style*="cyan"],
*::after[style*="cyan"] {
    display: none !important;
}
/* Target specific header area */
#header::before, #header::after,
.header-nav::before, .header-nav::after {
    display: none !important;
}
/* Hide any fixed elements with cyan color at top */
div[style*="position: fixed"][style*="top: 0"],
div[style*="position:fixed"][style*="top:0"] {
    background: transparent !important;
    border: none !important;
}
/* Override inline styles */
[style*="border-bottom"][style*="cyan"] {
    border-bottom: none !important;
}
</style>

<div id="nprogress">
    <div class="bar">
        <div class="peg"></div>
    </div>
</div>

<script>
// Always-Visible Loading Bar
(function() {
    var nprogress = {
        version: '1.0',
        started: false,
        minDuration: 600, // Minimum display time in ms
        startTime: 0,
        
        start: function() {
            if (this.started) return;
            this.started = true;
            this.startTime = Date.now();
            
            var bar = document.querySelector('#nprogress .bar');
            if (!bar) return;
            
            bar.style.opacity = '1';
            this.set(0);
            
            var self = this;
            (function step() {
                setTimeout(function() {
                    if (!self.started) return;
                    self.inc();
                    step();
                }, 150); // Slower increment
            })();
        },
        
        set: function(n) {
            var bar = document.querySelector('#nprogress .bar');
            if (!bar) return;
            
            n = Math.min(1, Math.max(0, n));
            bar.style.width = (n * 100) + '%';
            
            if (n === 1) {
                var self = this;
                // Disappear quickly
                setTimeout(function() {
                    bar.style.opacity = '0';
                    setTimeout(function() {
                        self.started = false;
                        bar.style.width = '0%';
                    }, 200);
                }, 50);
            }
        },
        
        inc: function() {
            var bar = document.querySelector('#nprogress .bar');
            if (!bar) return;
            
            var currentWidth = parseFloat(bar.style.width) || 0;
            var percent = currentWidth / 100;
            
            if (percent >= 1) return;
            
            var rnd = 0;
            if (percent >= 0 && percent < 0.2) {
                rnd = 0.12; // Faster at start
            } else if (percent >= 0.2 && percent < 0.5) {
                rnd = 0.06;
            } else if (percent >= 0.5 && percent < 0.8) {
                rnd = 0.03;
            } else if (percent >= 0.8 && percent < 0.99) {
                rnd = 0.008; // Very slow near end
            }
            
            percent = Math.min(0.994, percent + rnd);
            this.set(percent);
        },
        
        done: function() {
            if (!this.started) return;
            this.set(1);
        }
    };
    
    // Start on page load
    if (document.readyState === 'loading') {
        nprogress.start();
    }
    
    // Complete when page loads
    window.addEventListener('load', function() {
        nprogress.done();
    });
    
    // ALWAYS show on ANY click - NO JQUERY
    document.addEventListener('click', function(e) {
        var target = e.target;
        
        // Check if clicking inside sidebar
        var isSidebarClick = false;
        var tempTarget = target;
        while (tempTarget && tempTarget !== document.body) {
            if (tempTarget.classList && (
                tempTarget.classList.contains('sidebar') ||
                tempTarget.classList.contains('nav-content') ||
                tempTarget.classList.contains('sidebar-nav'))) {
                isSidebarClick = true;
                break;
            }
            tempTarget = tempTarget.parentElement;
        }
        
        // Find parent link
        while (target && target.tagName !== 'A') {
            target = target.parentElement;
        }
        
        if (target && target.tagName === 'A') {
            var href = target.getAttribute('href');
            var targetAttr = target.getAttribute('target');
            var onclick = target.getAttribute('onclick');
            var dataToggle = target.getAttribute('data-bs-toggle');
            
            // Ignore collapse toggles (like expanding sidebar menus)
            if (dataToggle === 'collapse') {
                return;
            }
            
            // Show for navigation OR sidebar clicks
            if (isSidebarClick ||
                (href && 
                href !== '#' && 
                !href.startsWith('javascript:') && 
                targetAttr !== '_blank') ||
                (onclick && (onclick.includes('CallSideBar') || onclick.includes('location')))) {
                
                // Always restart loading
                if (nprogress.started) {
                    nprogress.started = false;
                }
                nprogress.start();
            }
        }
    }, true);
    
    // Intercept CallSideBar function if it exists
    if (typeof CallSideBar !== 'undefined') {
        var originalCallSideBar = window.CallSideBar;
        window.CallSideBar = function() {
            if (nprogress.started) {
                nprogress.started = false;
            }
            nprogress.start();
            return originalCallSideBar.apply(this, arguments);
        };
    }
    
    // Monitor page unload
    window.addEventListener('beforeunload', function() {
        nprogress.done();
    });
    
    // Fallback
    setTimeout(function() {
        nprogress.done();
    }, 12000);
    
    window.NProgress = nprogress;
})();
</script>

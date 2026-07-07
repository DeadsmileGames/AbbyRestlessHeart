x += vx;
y += vy;
alpha -= 0.025;
size -= 0.15;

if (alpha <= 0 || size <= 0) {
    instance_destroy();
}
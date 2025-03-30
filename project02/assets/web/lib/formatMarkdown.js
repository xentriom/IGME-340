export const formatMarkdown = (markdown) => {
  const formattedMarkdown = markdown
    .replace(/`([^`]+)`/g, '<code>$1</code>')
    .replace(/```([^`]+)```/g, '<pre>$1</pre>')
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
    .replace(/\*([^*]+)\*/g, '<em>$1</em>')
    .replace(/\n/g, '<br />');

  return formattedMarkdown;
}